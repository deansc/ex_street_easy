defmodule BuildingScrapperTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock

  import ExStreetEasy.BuildingScrapper

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "building_url should return streeteasy building url" do
  	assert building_url("the-adeline") == "http://streeteasy.com/building/the-adeline"
  end

  # use_cassette "streeteasy_vcr" do
  # end
end