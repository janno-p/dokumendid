class AddExtraData < ActiveRecord::Migration
  def change
    # Temporarily disable readonly for types
    DocAttributeType.class_eval { def readonly? ; false ; end }
    AtrTypeSelectionValue.class_eval { def readonly? ; false ; end }

    # DocType we're going to modify
    arve = DocType.find_by_type_name("arve")
    finantsaruanne = DocType.find_by_type_name("finantsaruanne")
    teabenoue = DocType.find_by_type_name("teabenoue")

    # New attribute types
    create_date_type("tasumise tähtaeg", [arve, 1, true])
    create_selection_type("salastatuse tase", ["salastamata", "asutusesiseseks kasutamiseks", "piiratud juurdepääsuga"], 0, [finantsaruanne, 1, true], [teabenoue, 4, true])
    create_selection_type("arve tasutud", ["Jah", "Ei"], 0, [arve, 2, true])
    create_number_type("saadaolev summa", [arve, 3, true])
    create_text_type("kliendi nimi", [arve, 4, true])
  end

  def create_date_type(name, *doc_types)
    attribute_type = DocAttributeType.create({ type_name: name,
                                               data_type_fk: 3,
                                               multiple_attributes: "N" })
    add_attibute_to_type(attribute_type, doc_types)
  end

  def create_number_type(name, *doc_types)
    attribute_type = DocAttributeType.create({ type_name: name,
                                               data_type_fk: 2,
                                               multiple_attributes: "N" })
    add_attibute_to_type(attribute_type, doc_types)
  end

  def create_text_type(name, *doc_types)
    attribute_type = DocAttributeType.create({ type_name: name,
                                               data_type_fk: 1,
                                               multiple_attributes: "N" })
    add_attibute_to_type(attribute_type, doc_types)
  end

  def create_selection_type(name, values, default, *doc_types)
    attribute_type = DocAttributeType.create({ type_name: name,
                                               data_type_fk: 4,
                                               multiple_attributes: "N" })
    attribute_values = values.each_with_index.map do |value, i|
      AtrTypeSelectionValue.create({ doc_attribute_type_fk: attribute_type,
                                     value_text: value,
                                     orderby: (i + 1) })
    end
    if default then
      attribute_type.default_selection_id_fk = attribute_values[default].atr_type_selection_value
    end
    add_attibute_to_type(attribute_type, doc_types)
  end

  def add_attibute_to_type(attribute_type, doc_types)
    doc_types.each do |doc_type, orderby, required|
      DocTypeAttribute.create({ doc_type: doc_type,
                                doc_attribute_type: attribute_type,
                                created_by_default: "Y",
                                orderby: orderby,
                                required: (required ? "Y" : "N") })
    end
  end
end
