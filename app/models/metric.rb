class Metric < ActiveRecord::Base
  belongs_to :service
  belongs_to :visualization

  has_many   :filters
  has_many   :vspecs
  has_many   :selectfs

  # Get the threshold attribute fro vspecs
  def get_threshold
    d = self.vspecs.select(:value).where(name: 'threshold').first
    return d != nil ? d.value : d
  end

  def get_domain_max
    d = self.vspecs.select(:value).where(name: 'domain_max').first
    return d != nil ? d.value : d
  end

  def get_domain_min
    d = self.vspecs.select(:value).where(name: 'domain_min').first
    return d != nil ? d.value : d
  end
end
