-- CreateTable
CREATE TABLE `dw_dimension_type_of_services` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ref_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `dw_dimension_type_of_services_ref_id_key`(`ref_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `dw_dimension_customers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ref_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `dw_dimension_customers_ref_id_key`(`ref_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `dw_dimension_establishments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ref_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `dw_dimension_establishments_ref_id_key`(`ref_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `dw_dimension_periods` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `exact_date` DATETIME(3) NOT NULL,
    `month` CHAR(2) NOT NULL,
    `year` CHAR(4) NOT NULL,
    `holiday` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FactServiceRequest` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ref_id` CHAR(36) NOT NULL,
    `type_of_service_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `establishment_id` INTEGER NOT NULL,
    `period_id` INTEGER NOT NULL,
    `total_amount` DECIMAL(12, 2) NOT NULL,
    `net_amount` DECIMAL(12, 2) NOT NULL,
    `taxes_amount` DECIMAL(12, 2) NOT NULL,

    UNIQUE INDEX `FactServiceRequest_ref_id_key`(`ref_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `FactServiceRequest` ADD CONSTRAINT `FactServiceRequest_type_of_service_id_fkey` FOREIGN KEY (`type_of_service_id`) REFERENCES `dw_dimension_type_of_services`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `FactServiceRequest` ADD CONSTRAINT `FactServiceRequest_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `dw_dimension_customers`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `FactServiceRequest` ADD CONSTRAINT `FactServiceRequest_establishment_id_fkey` FOREIGN KEY (`establishment_id`) REFERENCES `dw_dimension_establishments`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `FactServiceRequest` ADD CONSTRAINT `FactServiceRequest_period_id_fkey` FOREIGN KEY (`period_id`) REFERENCES `dw_dimension_periods`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
