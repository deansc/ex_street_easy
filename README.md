ExStreetEasy (work in progress)
===============================

StreetEasy active listing scrapper by building.

## Usage

Assuming the url of the building you're interested in is: `http://streeteasy.com/building/200-e-62`.

Here is the query you can perform:

```elixir
ExStreetEasy.BuildingScrapper.fetch("200-e-62")
# => [[id: "1180890", address: "#27E - 200 East 62nd Street",
  price: "$6,250,000   "],
# => [id: "1180566", address: "#12D - 200 East 62nd Street",
  price: "$4,160,000   "],
# => [id: "1181211", address: "#26A - 200 East 62nd Street",
  price: "$3,925,000   "]]