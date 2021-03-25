def common_attrs(message)
  {
    message_type: message.ais.message_type,
    repeat_indicator: message.ais.repeat_indicator,
    source_mmsi: message.ais.source_mmsi,
    category_description: message.ais.source_mmsi_info.category_description,
  }
end

def mystery_attrs(message)
  {
    designated_area_code: message.ais.designated_area_code,
    functional_id: message.ais.functional_id,
    full_dearmored_ais_payload: message.full_dearmored_ais_payload,
  }
end

def dimension_attrs(message)
  {
    ship_dimension_to_bow: message.ais.ship_dimension_to_bow,
    ship_dimension_to_port: message.ais.ship_dimension_to_port,
    ship_dimension_to_starboard: message.ais.ship_dimension_to_starboard,
    ship_dimension_to_stern: message.ais.ship_dimension_to_stern,
  }
end

def position_attrs(message)
  {
    latitude: message.ais.latitude.to_s[..7],
    longitude: message.ais.longitude.to_s[..9],
  }
end

def course_attrs(message)
  {
    course_over_ground: message.ais.course_over_ground,
    speed_over_ground: message.ais.speed_over_ground,
  }
end

def type_cnb_attrs(message)
  {
    navigational_status: message.ais.navigational_status,
    navigational_status_description: message.ais.navigational_status_description,
    true_heading: message.ais.true_heading,
    rate_of_turn: message.ais.rate_of_turn,
  }
end

def type_5_attrs(message)
  {
    ais_version: message.ais.ais_version,
    callsign: message.ais.callsign&.strip,
    destination: message.ais.destination&.strip,
    epfd_type: message.ais.epfd_type,
    eta: message.ais&.eta || "",
    imo_number: message.ais.imo_number,
    ship_name: message.ais.name&.strip,
    ship_cargo_type: message.ais.ship_cargo_type,
    ship_cargo_type_description: message.ais.ship_cargo_type_description,
    static_draught: message.ais.static_draught,
  }
end

def type_7_attrs(message)
  {
    ack1_mmsi: message.ais.ack1_mmsi,
    ack2_mmsi: message.ais.ack2_mmsi,
    ack3_mmsi: message.ais.ack3_mmsi,
    ack4_mmsi: message.ais.ack4_mmsi,
    ack1_sequence_number: message.ais.ack1_sequence_number,
    ack2_sequence_number: message.ais.ack2_sequence_number,
    ack3_sequence_number: message.ais.ack3_sequence_number,
    ack4_sequence_number: message.ais.ack4_sequence_number,
  }
end

def type_8_d200_f10_attrs(message)
  {
    course_quality: message.ais.dp.course_quality,
    dimension_beam: message.ais.dp.dimension_beam,
    dimension_draught: message.ais.dp.dimension_draught,
    dimension_length: message.ais.dp.dimension_length,
    european_vessel_id: message.ais.dp.european_vessel_id,
    hazardous_cargo: message.ais.dp.hazardous_cargo,
    heading_quality: message.ais.dp.heading_quality,
    load_status: message.ais.dp.load_status,
    ship_type: message.ais.dp.ship_type,
    speed_quality: message.ais.dp.speed_quality,
  }
end

def type_8_encrypted_attrs(message)
  {
    encrypted_data: message.ais.dp.encrypted_data_6b
  }
end

def type_9_attrs(message)
  {
    altitude_meters: message.ais.altitude_meters
  }
end

def type_10_attrs(message)
  {
    destination_mmsi: message.ais.destination_mmsi
  }
end

def type_15_attrs(message)
  {
    interrogation1_mmsi: message.ais.interrogation1_mmsi,
    interrogation1_type1: message.ais.interrogation1_type1,
    interrogation1_offset1: message.ais.interrogation1_offset1,
    interrogation1_type2: message.ais.interrogation1_type2,
    interrogation1_offset2: message.ais.interrogation1_offset2,
    interrogation2_mmsi: message.ais.interrogation2_mmsi,
    interrogation2_type: message.ais.interrogation2_type,
    interrogation2_offset: message.ais.interrogation2_offset,
  }
end

def type_18_attrs(message)
  {
    true_heading: message.ais.true_heading
  }
end

def type_21_attrs(message)
  {
    aid_type: message.ais.aid_type,
    epfd_type: message.ais.epfd_type,
    name_extension: message.ais.name_extension,
    off_position: message.ais.off_position?,
    ship_name: message.ais.name&.strip,
    virtual_aid: message.ais.virtual_aid?,
  }
end

def type_24_name_attrs(message)
  {
    ship_name: message.ais.name&.strip
  }
end

def type_24_static_attrs(message)
  {
    callsign: message.ais.callsign&.strip,
    ship_cargo_type: message.ais.ship_cargo_type,
    ship_cargo_type_description: message.ais.ship_cargo_type_description,
    vendor_id: message.ais.vendor_id,
    model_code: message.ais.model_code,
    serial_number: message.ais.serial_number,
  }
end

def type_24_aux_attrs(message)
  {
    mothership_mmsi: message.ais.mothership_mmsi
  }
end

def type_27_attrs(message)
  {
    navigational_status: message.ais.navigational_status,
    navigational_status_description: message.ais.navigational_status_description,
    gnss: message.ais.gnss?,
  }
end
