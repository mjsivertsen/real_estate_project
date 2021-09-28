class Property < ApplicationRecord
  belongs_to :agent
  has_one :address


  # SQL version of what I want this model to do:
  # SELECT p.id, p.price, p.beds, p.baths, p.sq_ft, p.agent_id, a.email, a.first_name, a.last_name, ad.street, ad.city, ad.zip
  # FROM properties AS p
  # INNER JOIN agents AS a ON a.id = p.agent_id
  # INNER JOIN addresses AS ad ON ad.property_id = p.id
  # WHERE p.sold != true
  # ORDER BY a.id;

  def self.available
    select("p.id, p.price, p.beds, p.baths, p.sq_ft, p.agent_id, a.email, a.first_name, a.last_name, ad.street, ad.city, ad.zip")
    .from("properties AS p")
    .joins("INNER JOIN agents AS a ON a.id = p.agent_id
            INNER JOIN addresses AS ad ON ad.property_id = p.id")
    .where("p.sold != true")
    .order("a.id")
  end
end
