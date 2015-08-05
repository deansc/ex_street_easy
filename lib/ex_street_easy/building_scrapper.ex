defmodule ExStreetEasy.BuildingScrapper do 
  require Logger

  @streeteasy_url Application.get_env(:ex_street_easy, :streeteasy_url)

  def fetch(building) do
    building_url(building)
    |> HTTPotion.get
    |> extract_body
    |> extract_active_sales
    |> Enum.map &(build_appt_hashdict(&1))
  end

  def building_url(building), do: "#{@streeteasy_url}/building/#{building}"

  def extract_body(%HTTPotion.Response{status_code: 200, body: body, headers: _}), do: body
  def extract_body(%HTTPotion.Response{status_code: _, body: _, headers: _}) do 
    IO.puts "Error fetching from StreetEasy" 
    System.halt(2)
  end

  def extract_active_sales(html) do 
    html 
    |> Floki.find(".listings_table_container") |> Enum.at(0) 
    |> Floki.find(".nice_table, .building-pages") |> Enum.at(0) 
    |> Floki.find("tr")
    |> Enum.drop(1)
  end

  def build_appt_hashdict(tr) do 
    Logger.info "Appt id: #{extract_appt_id(tr)}" 
    [
      id: extract_appt_id(tr), 
      address: extract_address(tr), 
      price: extract_price(tr)
    ] 
  end

  def extract_appt_id(tr) do 
    tr 
    |> Floki.attribute("id")
    |> Enum.at(0) 
    |> String.split("_") 
    |> Enum.at(1)
  end

  def extract_address(tr) do 
    tr 
    |> Floki.find(".address a") 
    |> Enum.at(0) 
    |> Floki.text
  end

  def extract_price(tr) do 
    tr 
    |> Floki.find(".price") 
    |> Enum.at(0) 
    |> Floki.text |> String.strip |> String.strip ?\x{00A0}
  end

end