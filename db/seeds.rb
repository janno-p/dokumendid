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

DocCatalog.create([
  { doc_catalog: 1,
    doc_catalog_type_fk: 2,
    name: 'sisse tulnud',
    level: 1,
    upper_catalog_fk: 0,
    folder: '/home/t567245/doc_root/1' },
  { doc_catalog: 2,
    doc_catalog_type_fk: 2,
    name: 'teated',
    level: 1,
    upper_catalog_fk: 0,
    folder: '/home/t567245/doc_root/2' },
  { doc_catalog: 3,
    doc_catalog_type_fk: 2,
    name: 'toojuhendid',
    level: 1,
    upper_catalog_fk: 0,
    folder: '/home/t567245/doc_root/3' },
  { doc_catalog: 4,
    doc_catalog_type_fk: 2,
    name: 'teabenouded',
    level: 2,
    upper_catalog_fk: 1,
    folder: '/home/t567245/doc_root/1/1' },
  { doc_catalog: 5,
    doc_catalog_type_fk: 2,
    name: 'teated synnipaevadest',
    level: 2,
    upper_catalog_fk: 2,
    folder: '/home/t567245/doc_root/2/1' },
  { doc_catalog: 6,
    doc_catalog_type_fk: 2,
    name: 'puhkusegraafikud',
    level: 2,
    upper_catalog_fk: 2,
    folder: '/home/t567245/doc_root/2/2' },
  { doc_catalog: 7,
    doc_catalog_type_fk: 2,
    name: 'teated tooaja muudatustest',
    level: 2,
    upper_catalog_fk: 2,
    folder: '/home/t567245/doc_root/2/3' }])

# Temporarily disable readonly for DocStatusTypes
DocStatusType.class_eval do
  def readonly?
    false
  end
end

DocStatusType.create([
  { doc_status_type: 1,
    type_name: 'vastu voetud' },
  { doc_status_type: 2,
    type_name: 'vastamisel' },
  { doc_status_type: 3,
    type_name: 'kooskolastatud' },
  { doc_status_type: 4,
    type_name: 'vastatud' },
  { doc_status_type: 5,
    type_name: 'koostamisel' }])

# Temporarily disable readonly for DocSubjectRelationTypes
DocSubjectRelationType.class_eval do
  def readonly?
    false
  end
end

DocSubjectRelationType.create([
  { doc_subject_relation_type: 1,
    type_name: 'autor' },
  { doc_subject_relation_type: 2,
    type_name: 'tema kohta' },
  { doc_subject_relation_type: 3,
    type_name: 'talle saadetud' },
  { doc_subject_relation_type: 4,
    type_name: 'saatja' }])

# Temporarily disable readonly for DocSubjectTypes
DocSubjectType.class_eval do
  def readonly?
    false
  end
end

DocSubjectType.create([
  { doc_subject_type: 1,
    type_name: 'isik' },
  { doc_subject_type: 2,
    type_name: 'ettevote' }])

# Temporarily disable readonly for DocTypes
DocType.class_eval do
  def readonly?
    false
  end
end

DocType.create([
  { doc_type: 1,
    super_type_fk: 0,
    level: 1,
    type_name: 'finantsdokument' },
  { doc_type: 2,
    super_type_fk: 0,
    level: 1,
    type_name: 'leping' },
  { doc_type: 3,
    super_type_fk: 0,
    level: 1,
    type_name: 'valjast saadetud' },
  { doc_type: 4,
    super_type_fk: 0,
    level: 1,
    type_name: 'maaratlemata' },
  { doc_type: 5,
    super_type_fk: 1,
    level: 2,
    type_name: 'arve' },
  { doc_type: 6,
    super_type_fk: 1,
    level: 2,
    type_name: 'finantsaruanne' },
  { doc_type: 7,
    super_type_fk: 2,
    level: 2,
    type_name: 'tarneleping' },
  { doc_type: 8,
    super_type_fk: 2,
    level: 2,
    type_name: 'yyrileping' },
  { doc_type: 9,
    super_type_fk: 2,
    level: 2,
    type_name: 'tooleping' },
  { doc_type: 10,
    super_type_fk: 3,
    level: 2,
    type_name: 'teabenoue' }])

# Temporarily disable readonly for Customers
Customer.class_eval do
  def readonly?
    false
  end
end

Customer.create([
  { customer: 1,
    subject_fk: 4,
    subject_type_fk: 1 },
  { customer: 2,
    subject_fk: 5,
    subject_type_fk: 1 },
  { customer: 3,
    subject_fk: 2,
    subject_type_fk: 2 }])

# Temporarily disable readonly for Employees
Employee.class_eval do
  def readonly?
    false
  end
end

Employee.create([
  { employee: 1,
    person_fk: 1,
    enterprise_fk: 1,
    active: 'Y' },
  { employee: 2,
    person_fk: 2,
    enterprise_fk: 1,
    active: 'Y' },
  { employee: 3,
    person_fk: 3,
    enterprise_fk: 1,
    active: 'Y' }])

# Temporarily disable readonly for Enterprises
Enterprise.class_eval do
  def readonly?
    false
  end
end

Enterprise.create([
  { enterprise: 1,
    name: 'Yhendatud Systeemid',
    full_name: 'Oy yhendatud Systeemid Ltd',
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) },
  { enterprise: 2,
    name: 'Torupood',
    full_name: 'Torupood OY',
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) }])

# Temporarily disable readonly for People
Person.class_eval do
  def readonly?
    false
  end
end

Person.create([
  { person: 1,
    first_name: 'Juhan',
    last_name: 'Juurikas',
    identity_code: '54637474',
    birth_date: DateTime.civil(1967, 11, 11),
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) },
  { person: 2,
    first_name: 'Marten',
    last_name: 'Maasikas',
    identity_code: '672727337XX',
    birth_date: DateTime.civil(1977, 11, 11),
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) },
  { person: 3,
    first_name: 'Tanel',
    last_name: 'Tuisk',
    identity_code: '672727337XX',
    birth_date: DateTime.civil(1980, 11, 11),
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) },
  { person: 4,
    first_name: 'Kaarel',
    last_name: 'Klient',
    identity_code: '5555555555XXXX',
    birth_date: DateTime.civil(1970, 11, 11),
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) },
  { person: 5,
    first_name: 'Anna',
    last_name: 'Aru',
    identity_code: '57838222',
    birth_date: DateTime.civil(1975, 11, 11),
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) },
  { person: 6,
    first_name: 'Tauno',
    last_name: 'Toru',
    identity_code: '672727337XX',
    birth_date: DateTime.civil(1977, 11, 11),
    created: DateTime.civil(2014, 4, 6, 20, 14, 16) }])

# Temporarily disable readonly for UserAccounts
UserAccount.class_eval do
  def readonly?
    false
  end
end

UserAccount.create([
  { user_account: 1,
    subject_type_fk: 3,
    subject_fk: 1,
    username: 'juhan',
    passw: 'c3833e23112f86f172ab150a50526843',
    status: 1 },
  { user_account: 2,
    subject_type_fk: 3,
    subject_fk: 2,
    username: 'marten',
    passw: '37b4931088193a73b6561bae19bf06d9',
    status: 1 },
  { user_account: 3,
    subject_type_fk: 3,
    subject_fk: 3,
    username: 'tanel',
    passw: '4579f13a9f0266d03218017ebe4e67c7',
    status: 1 },
  { user_account: 4,
    subject_type_fk: 4,
    subject_fk: 1,
    username: 'kaarel',
    passw: 'kmmm89',
    status: 1 }])
