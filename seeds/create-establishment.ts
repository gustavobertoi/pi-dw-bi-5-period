import { faker } from "@faker-js/faker";

import { PrismaClient } from "@prisma/client";

const client = new PrismaClient();

(async () => {
  await client.$connect();
  const promises: Promise<any>[] = [];
  for (let i = 0; i <= 10; i++) {
    const establishment = {
      refId: faker.string.uuid(),
      name: faker.company.name(),
    };
    console.log("Creating establishment", establishment);
    promises.push(
      client.dimensionEstablishment.create({
        data: {
          ref_id: establishment.refId,
          name: establishment.name,
        },
      })
    );
  }
  await Promise.all(promises);
})()
  .catch(console.error)
  .finally(async () => client.$disconnect());
