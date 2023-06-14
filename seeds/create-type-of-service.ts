import { faker } from "@faker-js/faker";

import { PrismaClient } from "@prisma/client";

const client = new PrismaClient();

const typeOfServices = [
  {
    refId: faker.string.uuid(),
    name: "Haircut service",
  },
  {
    refId: faker.string.uuid(),
    name: "Eyebrow service",
  },
  {
    refId: faker.string.uuid(),
    name: "Makeup service",
  },
  {
    refId: faker.string.uuid(),
    name: "Beard cutting service",
  },
  {
    refId: faker.string.uuid(),
    name: "Skin cleaning service",
  },
];

(async () => {
  await client.$connect();

  for await (const typeOfService of typeOfServices) {
    console.log("Creating typeOfService", typeOfService);
    await client.dimensionTypeOfService.create({
      data: {
        ref_id: typeOfService.refId,
        name: typeOfService.name,
      },
    });
  }
})()
  .catch(console.error)
  .finally(async () => client.$disconnect());
