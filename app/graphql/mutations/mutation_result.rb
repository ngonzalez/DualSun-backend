module Mutations
  class MutationResult
    def self.call(obj: {}, success: false, errors: [])
      obj.merge(success: success, errors: errors)
    end
  end
end
