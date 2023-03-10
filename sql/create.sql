CREATE TABLE "users" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar,
  "username" varchar,
  "password" varchar,
  "isAdmin" boolean,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "restaurants" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar,
  "description" varchar,
  "latitude" varchar,
  "longitude" varchar,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "reviews" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "user_id" int,
  "restaurants_id" int UNIQUE,
  "rating" varchar,
  "text" varchar,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "comments" (
  "text" varchar,
  "user_id" int UNIQUE,
  "review_id" int UNIQUE,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "categories" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar
);

ALTER TABLE "reviews" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("restaurants_id") REFERENCES "restaurants" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "comments" ADD FOREIGN KEY ("review_id") REFERENCES "reviews" ("id");

CREATE TABLE "categories_restaurants" (
  "categories_id" int,
  "restaurants_id" int,
  PRIMARY KEY ("categories_id", "restaurants_id")
);

ALTER TABLE "categories_restaurants" ADD FOREIGN KEY ("categories_id") REFERENCES "categories" ("id");

ALTER TABLE "categories_restaurants" ADD FOREIGN KEY ("restaurants_id") REFERENCES "restaurants" ("id");
