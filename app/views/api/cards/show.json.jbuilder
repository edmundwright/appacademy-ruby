json.extract! @card, :id, :title, :description
json.items @card.items do |item|
  json.extract! item, :id, :title, :done
end
