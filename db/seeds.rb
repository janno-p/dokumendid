# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Temporarily disable readonly for DataTypes
AtrTypeSelectionValue.class_eval do
  def readonly?
    false
  end
end

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

# Temporarily disable readonly for DataTypes
DataType.class_eval do
  def readonly?
    false
  end
end

data_types = DataType.create([
  { data_type: 1,
    type_name: 'string' },
  { data_type: 2,
    type_name: 'number' },
  { data_type: 3,
    type_name: 'kuupaev' },
  { data_type: 4,
    type_name: 'valik nimekirjast' }])

# Temporarily disable readonly for DocAttributeTypes
DocAttributeType.class_eval do
  def readonly?
    false
  end
end

DocAttributeType.create([
  { doc_attribute_type: 1,
    default_selection_id_fk: nil,
    type_name: 'saatjad',
    default_value_text: nil,
    data_type_fk: 1,
    multiple_attributes: 'N'},
  { doc_attribute_type: 2,
    default_selection_id_fk: 4,
    type_name: 'vastamise tahtaeg',
    default_value_text: nil,
    data_type_fk: 4,
    multiple_attributes: 'N' },
  { doc_attribute_type: 3,
    default_selection_id_fk: nil,
    type_name: 'formaat',
    default_value_text: nil,
    data_type_fk: 1,
    multiple_attributes: 'N' }])
