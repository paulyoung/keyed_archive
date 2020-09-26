class KeyedArchive

  # Loops through the entries within '$top' 
  # to replace any values that are pointers to objects.
  def unpacked_top

    # Create the return value
    unpacked_top = Hash.new

    # Loop over each pair in the '$top' hash
    # to recursively replace the values
    @top.each_pair do |key, value|
      unpacked_top[key] = recursive_replace(value)
    end

    # Politely return, our job is done
    return unpacked_top
  end

  # Handles the recursive replacement of values within the 
  # '$objects' array. 
  def recursive_replace(value)
    # By default we just return the value itself, usually a String
    to_return = value

    if value.is_a? String and value == "$null"
      to_return = nil
    end

    # If we have an Integer, we want to bring in the object 
    # that Integer points to
    if value.is_a? Integer

      to_return = recursive_replace(@objects[value])

    # If we have a Hash, we want to check each entry 
    # and replace any values which need it
    elsif value.is_a? Hash

      # Build up a new Hash
      to_return = Hash.new

      # Loop over the pairs to check the key, value, or both
      value.each_pair do |tmp_key, tmp_value|

        # If this points to an array of objects, 
        # then we should bring those values in
        if tmp_key == "NS.objects"
          new_array = Array.new
          tmp_value.each do |entry|
            new_array.push(recursive_replace(entry))
          end
          to_return[tmp_key] = new_array

        # Handle an edge case in kCLPlacemarkCodingKeyRegion objects
        elsif tmp_key == "reserved"
          to_return[tmp_key] = tmp_value

        # Otherwise, we just want to replace the value with
        # its recursive version
        else
          to_return[tmp_key] = recursive_replace(tmp_value)
        end
      end
    end

    # Give back the value, politely
    return to_return
  end
end
