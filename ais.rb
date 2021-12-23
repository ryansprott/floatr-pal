#!/usr/bin/env /RBENV_PATH/.rbenv/shims/ruby

RAILS_APPLICATION_PATH = "/PATH/TO/YOUR/RAILS/APP/ENDING/IN/floatr"

require "active_record"
require "nmea_plus"
require "date"
require "/FLOATR_SERVICE_PATH/attrs.rb"

model_paths = ["/app/models/concerns/*.rb", "/app/models/*.rb"]
model_paths.each do |model_path|
  Dir.glob(File.expand_path(RAILS_APPLICATION_PATH + model_path, __FILE__)).sort.each do |file|
    require file
  end
end

ActiveRecord::Base.establish_connection(adapter: "postgresql", database: "floatr_development")

source_decoder = NMEAPlus::SourceDecoder.new(ARGF)

source_decoder.each_complete_message do |message|
  begin
    if message.ais.is_a?(NMEAPlus::Message::AIS::VDMPayload::VDMMsg)
      source = Source.find_or_create_by!({ mmsi: message.ais.source_mmsi })

      case message.ais.message_type
      when 1..3
        msg = Message.new(common_attrs(message))
        msg.build_course(course_attrs(message))
        msg.build_position(position_attrs(message))
        msg.build_specific(type_cnb_attrs(message))
        msg.save
      when 4
        msg = Message.new(common_attrs(message))
        msg.build_position(position_attrs(message))
        msg.build_specific({})
        msg.save
      when 5
        msg = Message.new(common_attrs(message))

        dim = Dimension.new(dimension_attrs(message))
        unless dim.totally_invalid? || dim.weird?
          source.last_area = dim.total_area
          source.last_aspect_ratio = dim.aspect_ratio
          msg.build_dimension(dim.attributes)
        end

        msg.build_specific(type_5_attrs(message))
        destination = msg.specific.destination
        if destination.present? && destination != source.last_destination
          source.last_destination = destination
        end

        msg.save

        source.static_data_received = true
        source.ship_name = msg.specific.ship_name unless source.ship_name
        source.callsign = msg.specific.callsign unless source.callsign
      when 6
        msg = Message.new(common_attrs(message))
        msg.build_mystery(mystery_attrs(message))
        msg.save
      when 7
        msg = Message.new(common_attrs(message))
        msg.build_specific(type_7_attrs(message))
        msg.save
      when 8
        msg = Message.new(common_attrs(message))

        case message.ais.dp
        when NMEAPlus::Message::AIS::VDMPayload::VDMMsg8d200f10
          msg.build_specific(type_8_d200_f10_attrs(message))
        when NMEAPlus::Message::AIS::VDMPayload::VDMMsg8USCGEncrypted
          msg.build_specific(type_8_encrypted_attrs(message))
        else
          msg.build_mystery(mystery_attrs(message))
        end

        msg.save
      when 9
        msg = Message.new(common_attrs(message))
        msg.build_course(course_attrs(message))
        msg.build_position(position_attrs(message))
        msg.build_specific(type_9_attrs(message))
        msg.save
      when 10
        msg = Message.new(common_attrs(message))
        msg.build_specific(type_10_attrs(message))
        msg.save
      when 15
        msg = Message.new(common_attrs(message))
        msg.build_specific(type_15_attrs(message))
        msg.save
      when 18
        msg = Message.new(common_attrs(message))
        msg.build_course(course_attrs(message))
        msg.build_position(position_attrs(message))
        msg.build_specific(type_18_attrs(message))
        msg.save
      when 21
        msg = Message.new(common_attrs(message))
        msg.build_position(position_attrs(message))
        msg.build_dimension(dimension_attrs(message))
        msg.build_specific(type_21_attrs(message))
        msg.save

        source.static_data_received = true
        source.ship_name = msg.specific.ship_name unless source.ship_name
      when 24
        msg = Message.new(common_attrs(message))

        if 0 == message.ais.part_number
          msg.build_specific(type_24_name_attrs(message))
          source.ship_name = msg.specific.ship_name unless source.ship_name
        else
          msg.build_specific(type_24_static_attrs(message))
          source.callsign = msg.specific.callsign unless source.callsign
        end

        if message.ais.auxiliary_craft?
          msg.build_specific(type_24_aux_attrs(message))
        else
          msg.build_dimension(dimension_attrs(message))
        end

        source.static_data_received = true
        msg.save
      when 27
        msg = Message.new(common_attrs(message))
        msg.build_course(course_attrs(message))
        msg.build_position(position_attrs(message))
        msg.build_specific(type_27_attrs(message))
        msg.save
      end

      source.updated_at = DateTime.now
      source.save!
    end
  rescue => e
    puts "Caught #{e}"
  end
end
