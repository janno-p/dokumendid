# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Attribute type selection values

atr_type_selection_values = AtrTypeSelectionValue.create([
  { atr_type_selection_value: 1,
    doc_attribute_type_fk: 2,
    value_text: 'kahe paeva jooksul',
    orderby: 1 },
  { atr_type_selection_value: 2,
    doc_attribute_type_fk: 2,
    value_text: 'nadala jooksul',
    orderby: 2 },
  { atr_type_selection_value: 3,
    doc_attribute_type_fk: 2,
    value_text: 'kuu aja jooksul',
    orderby: 3 },
  { atr_type_selection_value: 4,
    doc_attribute_type_fk: 2,
    value_text: 'maaramata',
    orderby: 4 }])
