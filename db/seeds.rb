require "open-uri"
print "Reset data base"
Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

def id_recup_ingredient(ingredient)
    ingredient = Ingredient.find_by(name: ingredient)
    ingredient.id
end

def id_recup_cocktail(cocktail)
    cocktail = Cocktail.find_by(name: cocktail)
    cocktail.id
end

results = JSON.parse(open("http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list").read)
results["drinks"].each {|ingredient| Ingredient.create!(name: ingredient.values.first)}
puts "ingredients created"

cocktails = [
  {name: "mojito"},
  {name: "daikiri"},
  {name: "tequila sunrise"}
]

Cocktail.create!(cocktails)
puts "cocktails created"

mojito_id = id_recup_cocktail("mojito")
daikiri_id = id_recup_cocktail("daikiri")
tequila_id = id_recup_cocktail("tequila sunrise")

syrup_id = id_recup_ingredient("Sugar syrup")
citron_id = id_recup_ingredient("Absolut Citron")
rum_id = id_recup_ingredient("Light rum")

puts "id assigned"

doses = [
  {description: "6 cl", cocktail_id: mojito_id, ingredient_id: rum_id },
  {description: "3 cl", cocktail_id: mojito_id ,ingredient_id: citron_id },
  {description: "10 cl", cocktail_id: mojito_id ,ingredient_id: id_recup_ingredient("Carbonated water")},
  {description: "2 cl", cocktail_id: mojito_id ,ingredient_id: syrup_id },

  {description: "4 cl", cocktail_id: daikiri_id ,ingredient_id: rum_id },
  {description: "2 cl", cocktail_id: daikiri_id ,ingredient_id: citron_id },
  {description: "1 cl", cocktail_id: daikiri_id ,ingredient_id: syrup_id },

  {description: "6 cl", cocktail_id: tequila_id ,ingredient_id: id_recup_ingredient("Tequila")},
  {description: "12 cl", cocktail_id: tequila_id ,ingredient_id: id_recup_ingredient("Orange juice")},
  {description: "2 cl", cocktail_id: tequila_id ,ingredient_id: syrup_id}
]

Dose.create!(doses)

puts "dose created"
