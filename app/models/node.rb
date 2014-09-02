class Node < ActiveRecord::Base
  scope :asc_name,       -> { order(name: :asc) }
  scope :asc_type,       -> { order(node_type: :asc) }

  # Return nodes and link mapping
  def self.get_force(options, select_statement, group_statement)
    nodes = []
    nodeIndexMapping = Hash.new
    index = 0
    self.where("node_type = ? or node_type = ? or node_type = ?", "RNC", "SGSN", "GGSN")
        .asc_type
        .each do |d|
          nodeIndexMapping[d.name] = index
          index += 1
          nodes << d
        end

    links = []
    tempHash = {}
    # Loop for all links
    prng = Random.new
    Link.where("link_type = ? or link_type = ?", "Gn-CP", "IuPS")
        .each do |d|
          tempHash = d.attributes
          tempHash[:source] = nodeIndexMapping[d.source]
          tempHash[:target] = nodeIndexMapping[d.target]
          if (d.link_type == "IuPS")
            value = MetricHttp.facebook
                          .region(options[:region])
                          .site(options[:site])
                          .sgsn(d.source)
                          .apn(d.target)
                          .start(options[:start])
                          .stop(options[:stop])
                          .average("#{options[:metric_attr]}")
                          .to_f

          else #elsif (d.link_type == "Gn-CP")
            value = MetricHttp.facebook
                          .region(options[:region])
                          .site(options[:site])
                          .sgsn(d.source)
                          .apn(d.target)
                          .start(options[:start])
                          .stop(options[:stop])
                          .average("#{options[:metric_attr]}")
                          .to_f
          end
          puts value
          tempHash[:value] = 1
          tempHash[:metric_value] = value #prng.rand(1..1000) / 10.0
          links << tempHash
        end

    return { :nodes => nodes, :links => links }

  end

  # Build a hirarchical three from the nodes and links.
  # Use loop for now
  # TODO: Recursive function
  def self.get_tree
    nodes = []
    self.all ##where("node_type = ? or node_type = ?", "RNC", "SGSN")
        .asc_type
        .each do |d|
          nodes << d
        end

    links = []
    tempHash = {}
    # Loop for all links
    Link.all
        .where("link_type = ?", "IuPS")
        .each do |d|
          tempHash = d.attributes
          tempHash[:source] = nodeIndexMapping[d.source]
          tempHash[:target] = nodeIndexMapping[d.target]
          links << tempHash
        end

    return { :nodes => nodes, :links => links }
  end

end
