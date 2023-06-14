/*
  Warnings:

  - Added the required column `name` to the `dw_dimension_customers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `dw_dimension_establishments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `dw_dimension_type_of_services` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `dw_dimension_customers` ADD COLUMN `name` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `dw_dimension_establishments` ADD COLUMN `name` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `dw_dimension_type_of_services` ADD COLUMN `name` VARCHAR(191) NOT NULL;
