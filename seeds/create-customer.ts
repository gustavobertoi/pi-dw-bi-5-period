import { faker } from "@faker-js/faker";

import { PrismaClient } from "@prisma/client";

const client = new PrismaClient();

(async () => {
  await client.$connect();
  const promises: Promise<any>[] = [];
  for (let i = 0; i <= 10; i++) {
    const customer = {
      refId: faker.string.uuid(),
      name: faker.person.fullName(),
    };
    console.log("Creating", customer);
    promises.push(
      client.dimensionCustomer.create({
        data: {
          ref_id: customer.refId,
          name: customer.name,
        },
      })
    );
  }
  await Promise.all(promises);
})()
  .catch(console.error)
  .finally(async () => client.$disconnect());
