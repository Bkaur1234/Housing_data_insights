-- Convert SaleDate to a standard date format
ALTER TABLE Housing_insights..NashvilleHousing
ADD SaleDateConverted DATE;

UPDATE Housing_insights..NashvilleHousing
SET SaleDateConverted = CONVERT(DATE, SaleDate);

-- Populate PropertyAddress data
UPDATE A
SET PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
FROM Housing_insights..NashvilleHousing A
JOIN Housing_insights..NashvilleHousing B ON A.ParcelID = B.ParcelID AND A.[UniqueID] <> B.[UniqueID]
WHERE A.PropertyAddress IS NULL;

-- Break out address into individual columns (Address, City)
ALTER TABLE Housing_insights..NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255),
    PropertySplitCity NVARCHAR(255);

UPDATE Housing_insights..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
    PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));

-- Parse OwnerAddress into individual columns (Address, City, State)
ALTER TABLE Housing_insights..NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255),
    OwnerSplitCity NVARCHAR(255),
    OwnerSplitState NVARCHAR(255);

UPDATE Housing_insights..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
    OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
    OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

-- Normalize 'SoldAsVacant' column values
UPDATE Housing_insights..NashvilleHousing
SET SoldAsVacant = CASE 
                        WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                    END;

-- Remove duplicate rows
WITH RowNumCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID) AS row_num
    FROM Housing_insights..NashvilleHousing
)
DELETE FROM RowNumCTE
WHERE row_num > 1;

-- Delete unused columns
ALTER TABLE Housing_insights..NashvilleHousing
DROP COLUMN OWNERADDRESS,
            TAXDISTRICT,
            PROPERTYADDRESS,
            SALEDATE;
