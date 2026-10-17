-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users_sessions" (
    "token_hash" TEXT NOT NULL,
    "account_id" TEXT NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_sessions_pkey" PRIMARY KEY ("token_hash")
);

-- CreateTable
CREATE TABLE "black_cards" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "pick" INTEGER NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "black_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "white_cards" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "white_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "decks" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "imported_deck_id" TEXT,
    "cah_official" BOOLEAN NOT NULL DEFAULT false,
    "created_by_id" TEXT,
    "deleted_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "decks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "decks_black_cards" (
    "deck_id" TEXT NOT NULL,
    "black_card_id" TEXT NOT NULL,

    CONSTRAINT "decks_black_cards_pkey" PRIMARY KEY ("deck_id","black_card_id")
);

-- CreateTable
CREATE TABLE "decks_white_cards" (
    "deck_id" TEXT NOT NULL,
    "white_card_id" TEXT NOT NULL,

    CONSTRAINT "decks_white_cards_pkey" PRIMARY KEY ("deck_id","white_card_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_sessions_account_id_idx" ON "users_sessions"("account_id");

-- AddForeignKey
ALTER TABLE "users_sessions" ADD CONSTRAINT "users_sessions_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "decks" ADD CONSTRAINT "decks_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "decks_black_cards" ADD CONSTRAINT "decks_black_cards_deck_id_fkey" FOREIGN KEY ("deck_id") REFERENCES "decks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "decks_black_cards" ADD CONSTRAINT "decks_black_cards_black_card_id_fkey" FOREIGN KEY ("black_card_id") REFERENCES "black_cards"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "decks_white_cards" ADD CONSTRAINT "decks_white_cards_deck_id_fkey" FOREIGN KEY ("deck_id") REFERENCES "decks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "decks_white_cards" ADD CONSTRAINT "decks_white_cards_white_card_id_fkey" FOREIGN KEY ("white_card_id") REFERENCES "white_cards"("id") ON DELETE CASCADE ON UPDATE CASCADE;
