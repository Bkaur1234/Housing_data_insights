# Nashville Housing Data Cleaning Project

## Overview
This repository contains SQL scripts for cleaning and preparing Nashville housing data obtained from [[link](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx)]. The data includes information about property sales in Nashville, including sale dates, prices, addresses, and other relevant details.

## Data Source
The Nashville housing data used in this project was obtained from [[link](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx)]. It includes information such as:

- Parcel ID
- Sale Price
- Sale Date
- Property Address
- Owner Address
- Tax District
- Legal Reference
- Sold As Vacant
- and more...

## Cleaning Process
The SQL scripts provided in this repository perform the following cleaning tasks:

1. **Standardize Date Format**: Converts the 'SaleDate' column to a standard date format.
2. **Populate Property Address Data**: Fills in missing property addresses by replacing them with available addresses based on the same Parcel ID.
3. **Break Out Address into Individual Columns**: Separates the 'PropertyAddress' column into 'PropertySplitAddress' and 'PropertySplitCity'.
4. **Parse Owner Address**: Parses the 'OwnerAddress' column into 'OwnerSplitAddress', 'OwnerSplitCity', and 'OwnerSplitState'.
5. **Normalize 'SoldAsVacant' Values**: Converts 'Y' and 'N' values in the 'SoldAsVacant' column to 'Yes' and 'No' respectively.
6. **Remove Duplicate Rows**: Identifies and removes duplicate rows based on a combination of selected columns.
7. **Delete Unused Columns**: Removes columns that are no longer needed after data cleaning.

## Usage
To use these scripts, simply run them in your SQL environment with the Nashville housing data imported into a compatible database. Make sure to replace any placeholders such as [[link](https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx)].
