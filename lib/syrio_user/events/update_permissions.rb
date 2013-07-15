require File.expand_path("../../events", __FILE__)

class SyrioUser::Events::UpdatePermissions < Ferret::Event::Base
  EVENT_TYPE = "syrio_user:update_permissions"
  
  self.schema = {
    "type" => "object",
    "required" => ["subject_uris", "object_uris"],
    "optional" => ["grant", "revoke"],
    "properties" => {
      "subject_uris" => {"type" => "array", "items" => {"type" => "string"}},
      "object_uris" => {"type" => "array", "items" => {"type" => "string"}},
      "grant" => {"type" => "array", "optional" => true, "items" => {
        "type" => "object",
        "properties" => {
          "permission" => {"type" => "string"},
          "until" => {"type" => "string", "format" => "time"}
        }
      }},
      "revoke" => {"type" => "array", "items" => {"type" => "string"}}
    }
  }
  
end