/*
  Warnings:

  - Added the required column `image` to the `AvailableAction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `image` to the `AvailableTrigger` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Zap` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Action" ADD COLUMN     "sortingOrder" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "public"."AvailableAction" ADD COLUMN     "image" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."AvailableTrigger" ADD COLUMN     "image" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."Trigger" ADD COLUMN     "metadata" JSONB NOT NULL DEFAULT '{}';

-- AlterTable
ALTER TABLE "public"."Zap" ADD COLUMN     "userId" INTEGER NOT NULL;

-- DropEnum
DROP TYPE "public"."TRIGGER";

-- CreateTable
CREATE TABLE "public"."ZapRun" (
    "id" TEXT NOT NULL,
    "zapId" TEXT NOT NULL,
    "metadata" JSONB NOT NULL,

    CONSTRAINT "ZapRun_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ZapRunOutbox" (
    "id" TEXT NOT NULL,
    "zapRunId" TEXT NOT NULL,

    CONSTRAINT "ZapRunOutbox_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ZapRunOutbox_zapRunId_key" ON "public"."ZapRunOutbox"("zapRunId");

-- AddForeignKey
ALTER TABLE "public"."Zap" ADD CONSTRAINT "Zap_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ZapRun" ADD CONSTRAINT "ZapRun_zapId_fkey" FOREIGN KEY ("zapId") REFERENCES "public"."Zap"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ZapRunOutbox" ADD CONSTRAINT "ZapRunOutbox_zapRunId_fkey" FOREIGN KEY ("zapRunId") REFERENCES "public"."ZapRun"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
