class AddExtraData < ActiveRecord::Migration
  def up
    # Temporarily disable readonly for types
    DocAttributeType.class_eval { def readonly? ; false ; end }
    AtrTypeSelectionValue.class_eval { def readonly? ; false ; end }

    # DocType we're going to modify
    arve = DocType.find_by_type_name("arve")
    finantsaruanne = DocType.find_by_type_name("finantsaruanne")
    teabenoue = DocType.find_by_type_name("teabenoue")
    tarneleping = DocType.find_by_type_name("tarneleping")
    tooleping = DocType.find_by_type_name("tooleping")
    uurileping = DocType.find_by_type_name("yyrileping")

    # New attribute types
    create_date_type("tasumise tähtaeg", [arve, 1, true])
    create_selection_type("salastatuse tase", ["salastamata", "asutusesiseseks kasutamiseks", "piiratud juurdepääsuga"], 0, [finantsaruanne, 4, true], [teabenoue, 4, true])
    create_selection_type("arve tasutud", ["Jah", "Ei"], 1, [arve, 2, true])
    create_number_type("saadaolev summa", [arve, 3, true])
    create_text_type("kliendi nimi", [arve, 4, true])
    create_text_type("ärinimi", [finantsaruanne, 1, true])
    create_text_type("audiitori nimi", [finantsaruanne, 2, false])
    create_date_type("läbiviimise kuupäev", [finantsaruanne, 3, false])
    create_text_type("lepingu number", [tarneleping, 1, true], [tooleping, 1, true], [uurileping, 1, true])
    create_text_type("tarnija nimi", [tarneleping, 2, true])
    create_text_type("ostja nimi", [tarneleping, 3, true])
    create_text_type("tööandja", [tooleping, 2, true])
    create_text_type("töövõtja", [tooleping, 3, true])
    create_date_type("tööleasumise aeg", [tooleping, 3, true])
    create_text_type("üürileandja", [uurileping, 2, true])
    create_text_type("üürnik", [uurileping, 3, true])
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
      AtrTypeSelectionValue.create({ doc_attribute_type_fk: attribute_type.doc_attribute_type,
                                     value_text: value,
                                     orderby: (i + 1) })
    end
    if default then
      attribute_type.default_selection_id_fk = attribute_values[default].atr_type_selection_value
      attribute_type.save
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
