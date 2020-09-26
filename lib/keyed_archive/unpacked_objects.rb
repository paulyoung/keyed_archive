class KeyedArchive

  # Loops through the entries within '$top' 
  # to replace any values that are pointers to objects.
  def unpacked_top

    # Create the return value
    unpacked_top = Hash.new

    # Loop over each pair in the '$top' hash
    # to recursively replace the values
    @top.each_pair do |key, value|
      unpacked_top[key] = recursive_replace(value, -1, [])
    end

    # Politely return, our job is done
    return unpacked_top
  end

  private

  # Handles the recursive replacement of values within the 
  # '$objects' array. Tracks the object locations it has 
  # already touched to prevent infinite loops. 
  def recursive_replace(value, current_location, locations)
    # By default we just return the value itself, usually a String
    to_return = value

    # If the value is really representing nil, change it to nil
    if value.is_a? String and value == "$null"
      to_return = nil
    end

    # If we have an Integer, we want to bring in the object 
    # that Integer points to
    if value.is_a? Integer

      # If we ever find a reference to one of our parents, just stop where we are
      if locations.include?(current_location)
        to_return = value
      else
        to_return = recursive_replace(@objects[value], value, locations.clone.push(current_location)) 
      end

    # If we have a Hash, we want to check each entry 
    # and replace any values which need it
    elsif value.is_a? Hash

      # Build up a new Hash
      to_return = Hash.new

      # Loop over the pairs to check the key, value, or both
      value.each_pair do |tmp_key, tmp_value|

        # If this points to an array of objects, 
        # then we should bring those values in
        if tmp_key == "NS.objects" or tmp_key == "NS.keys"
          new_array = Array.new
          tmp_value.each do |entry|
            new_array.push(recursive_replace(entry, entry, locations.clone.push(current_location)))
          end
          to_return[tmp_key] = new_array

        # Otherwise, we just want to replace the value with
        # its recursive version
        else
          to_return[tmp_key] = recursive_replace(tmp_value, tmp_value, locations.clone.push(current_location))
        end
      end
    end

    # Give back the value, politely
    return to_return
  end
end
