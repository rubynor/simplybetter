module Report
  def self.query_helper(num, type, klass)
    klass.constantize.all.select { |k| k.public_send(type).count > num }
  end

  module Application
    types = %w(ideas users)

    types.each do |type|
      define_singleton_method "with_#{type}" do |num = 0|
        parent::query_helper(num, type, 'Application')
      end
    end
  end

  module Customer
    define_singleton_method :with_applications do |num = 0|
      parent::query_helper(num, 'applications', 'Customer')
    end
  end
end
