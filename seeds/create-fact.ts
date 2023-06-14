import { faker } from "@faker-js/faker";

import { PrismaClient } from "@prisma/client";

const client = new PrismaClient();

(async () => {
  await client.$connect();

  const customers = await client.dimensionCustomer.findMany();
  const establishments = await client.dimensionEstablishment.findMany();
  const periods = await client.dimensionPeriod.findMany();
  const typeOfServices = await client.dimensionTypeOfService.findMany();

  type Fact = {
    refId: string;
    typeOfServiceId: number;
    customerId: number;
    periodId: number;
    establishmentId: number;
    totalAmount: number;
    taxAmount: number;
    netAmount: number;
  };

  const facts: Fact[] = [];

  for (const customer of customers) {
    for (const establishment of establishments) {
      for (const period of periods) {
        for (const typeOfService of typeOfServices) {
          const totalAmount = faker.number.int({
            min: 10,
            max: 200,
          });
          const taxAmount = totalAmount * 0.2;
          const netAmount = totalAmount - taxAmount;
          facts.push({
            refId: faker.string.uuid(),
            typeOfServiceId: typeOfService.id,
            customerId: customer.id,
            establishmentId: establishment.id,
            periodId: period.id,
            totalAmount,
            taxAmount,
            netAmount,
          });
        }
      }
    }
  }

  await Promise.all(
    facts.map(async (fact) => {
      console.log("Creating fact", fact);
      await client.factServiceRequest.create({
        data: {
          ref_id: fact.refId,
          establishment_id: fact.establishmentId,
          type_of_service_id: fact.typeOfServiceId,
          period_id: fact.periodId,
          customer_id: fact.customerId,
          net_amount: fact.netAmount,
          taxes_amount: fact.taxAmount,
          total_amount: fact.totalAmount,
        },
      });
    })
  );
})()
  .catch(console.error)
  .finally(async () => client.$disconnect());
