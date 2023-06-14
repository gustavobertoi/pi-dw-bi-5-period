import { faker } from "@faker-js/faker";

import { PrismaClient } from "@prisma/client";

const client = new PrismaClient();

(async () => {
  await client.$connect();
  const promises: Promise<any>[] = [];
  for (let i = 0; i <= 10; i++) {
    const exactDate = faker.date.recent();
    const year = exactDate.getFullYear();
    const month = exactDate.getMonth() + 1;
    const period = {
      exactDate,
      year: year.toString(),
      month: month.toString(),
      holiday: false,
    };
    console.log("Creating period", period);
    promises.push(
      client.dimensionPeriod.create({
        data: {
          exact_date: period.exactDate,
          year: period.year,
          month: period.month,
          holiday: period.holiday,
        },
      })
    );
  }
  await Promise.all(promises);
})()
  .catch(console.error)
  .finally(async () => client.$disconnect());
