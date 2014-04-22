class KeyedArchive
  def unpacked_objects
    objects = @objects.clone
    unpacked_objects = []

    objects.each_with_index do |object, index|
      if object.is_a? Hash
        object.each_pair do |key, value|
          if value.is_a? Hash
            uid = value['CF$UID']

            if uid
              new_object = {}
              new_object[key] = @objects[uid]
              objects.push new_object
              unpacked_objects.delete_at(index - 1)
            end
          else
            new_object = {}
            new_object[key] = value
            unpacked_objects.push new_object
          end
        end
      else
        unpacked_objects.push object
      end
    end

    return unpacked_objects
  end
end
