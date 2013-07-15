require File.expand_path("../../features", __FILE__)

class SyrioUser::Features::HasPermissions < Ferret::Feature::Base
  FEATURE_TYPE = "syrio_user:has_permissions"
  
  def self.event_types 
    [SyrioUser::Events::UpdatePermissions::EVENT_TYPE]
  end

  def self.subject_uris_for_event(event)
    event['subject_uris']
  end
  
  def self.object_uris_for_subject_and_event(subject_uri, event)
    event['object_uris']
  end
  
  def self.update(current_value, subject_uri, object_uri, event)
    new_value = current_value.merge(event['grant'])
    event['revoke'].each do |permission|
      new_value.delete(permission)
    end
    new_value
  end
  
  derive('has_permission?') do |value, permission, time|
    if entry = value[permission]
      if entry['until'].is_a?(Time)
        return time <= entry['until']
      else
        raise Ferret::MalformedFeatureValue.new("Expecting value for 'until' to be a Time, but was a #{entry['until'].class}")
      end
    else
      false
    end
  end
  
end