/*
Cleaning Data in SQL Queries
*/

Select*
From PortofolioProject.dbo.NashvilleHousing


-- Standardize Date Format

Alter table PortofolioProject.dbo.NashvilleHousing
Alter Column SaleDate Date


-- Populate Property Address data

Select*
From PortofolioProject..NashvilleHousing
--Where PropertyAddress is null
Order by [UniqueID ], ParcelID

Select t1.ParcelID, t1.PropertyAddress, t2.ParcelID, t2.PropertyAddress
From PortofolioProject..NashvilleHousing t1
Join NashvilleHousing t2
	 On t1.ParcelID = t2.ParcelID
	 And t1.[UniqueID ] <> t2.[UniqueID ]
--Where t1.PropertyAddress is null

Update PortofolioProject..NashvilleHousing
Set PropertyAddress = (
	Select Max(PropertyAddress)
	From PortofolioProject..NashvilleHousing t2
	Where t2.ParcelID = NashvilleHousing.ParcelID
	And t2.[UniqueID ] <> NashvilleHousing.[UniqueID ]
	And PropertyAddress is not null)
Where PropertyAddress is null


-- Breaking out PropertyAddress into Individual Columns (StreetAdress, City)

Select PropertyAddress
From PortofolioProject..NashvilleHousing

Select
PropertyAddress,
LEFT(PropertyAddress, Charindex(',', PropertyAddress) -1),
RIGHT(PropertyAddress, len(PropertyAddress) - CHARINDEX(',', PropertyAddress)-1)
From PortofolioProject..NashvilleHousing

ALter Table PortofolioProject.dbo.NashvilleHousing
Add PropertyStreetAddress nvarchar(250),
	PropertyCity nvarchar(250)

Update PortofolioProject..NashvilleHousing
Set PropertyStreetAddress = LEFT(PropertyAddress, Charindex(',', PropertyAddress) -1),
	PropertyCity = RIGHT(PropertyAddress, len(PropertyAddress) - CHARINDEX(',', PropertyAddress)-1)

Select*
From PortofolioProject..NashvilleHousing


-- Breaking out OwnerAddress into Individual Columns (StreetAdress, City, State)

Select OwnerAddress
From PortofolioProject..NashvilleHousing

Select
OwnerAddress,
LEFT(OwnerAddress, CHARINDEX(',', OwnerAddress)-1),
RIGHT(OwnerAddress, Len(OwnerAddress) - CHARINDEX(',', OwnerAddress)-1 )
From PortofolioProject..NashvilleHousing

Alter Table PortofolioProject..NashvilleHousing
Add OwnerStreetAddress nvarchar(250),
	OwnerCityAndState nvarchar(250)

Update PortofolioProject..NashvilleHousing
Set OwnerStreetAddress = LEFT(OwnerAddress, CHARINDEX(',', OwnerAddress)-1),
	OwnerCityAndState = RIGHT(OwnerAddress, Len(OwnerAddress) - CHARINDEX(',', OwnerAddress)-1 )

Select OwnerAddress, OwnerStreetAddress, OwnerCityAndState
From PortofolioProject..NashvilleHousing

Select
OwnerCityAndState,
LEFT(OwnerCityAndState, CHARINDEX(',', OwnerCityAndState)-1),
RIGHT(OwnerCityAndState, len(OwnerCityAndState) - CHARINDEX(',', OwnerCityAndState) -1)
From PortofolioProject..NashvilleHousing

Alter Table PortofolioProject..NashvilleHousing
Add OwnerCity nvarchar(250),
	OwnerState nvarchar(250)

Update PortofolioProject..NashvilleHousing
Set OwnerCity = LEFT(OwnerCityAndState, CHARINDEX(',', OwnerCityAndState)-1),
	OwnerState = RIGHT(OwnerCityAndState, len(OwnerCityAndState) - CHARINDEX(',', OwnerCityAndState) -1)

Select*
From PortofolioProject..NashvilleHousing


-- Using Parsename to Break down OwnerAddress into Individual Columns (Address, City, State)

Select
OwnerAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as OwnerStreetAdress,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) as OwnerCity,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) as OwnerState
FROM PortofolioProject..NashvilleHousing


-- Change Y and N to Yes and No in SoldAsVacant

Select SoldAsVacant, count(SoldAsVacant)
From PortofolioProject..NashvilleHousing
Group by SoldAsVacant

Select
SoldAsVacant,
CASE
	When SoldAsVacant = 'Y' then 'Yes'
	When SoldAsVacant = 'N' Then 'No'
	Else SoldAsVacant
	End
From PortofolioProject..NashvilleHousing

Update PortofolioProject..NashvilleHousing
Set SoldAsVacant = CASE
	When SoldAsVacant = 'Y' then 'Yes'
	When SoldAsVacant = 'N' Then 'No'
	Else SoldAsVacant
	End


-- Delete Duplicates

Select*
From PortofolioProject..NashvilleHousing

DELETE FROM PortofolioProject..NashvilleHousing
WHERE EXISTS (
    SELECT 1
    FROM PortofolioProject..NashvilleHousing NH2
    WHERE NH2.ParcelID = NashvilleHousing.ParcelID
      AND NH2.PropertyAddress = NashvilleHousing.PropertyAddress
      AND NH2.SalePrice = NashvilleHousing.SalePrice
      AND NH2.SaleDate = NashvilleHousing.SaleDate
      AND NH2.LegalReference = NashvilleHousing.LegalReference
      AND NH2.[UniqueID ] <> NashvilleHousing.[UniqueID ]
	  )

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From PortofolioProject..NashvilleHousing
)

Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


-- Delete Unused Columns

Select *
From PortofolioProject..NashvilleHousing


ALTER TABLE PortofolioProject..NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress, OwnerCityAndState, TaxDistrict
