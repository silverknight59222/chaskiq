# frozen_string_literal: true

class Dashboard
  attr_accessor :app, :range

  # d = Dashboard.new(app: App.find(n) )
  def initialize(app:, range:, package: nil)
    @app = app
    @package_name = package
    @range = (DateTime.parse(range[:from])..DateTime.parse(range[:to]))
  end

  def resource
    app
  end

  def visits
    # TODO: extends visits to be configurable ,
    # sql or redis , or another storage
    # like influx, google analytics ? or watheva
    # sql version

    # @app.visits
    #  .all.group_by_day(:created_at)
    #  .count.map do |o|
    # {
    #  "day": o.first.strftime('%F'),
    #  "value": o.last
    # }

    AppIdentity.new(app.key).visits.get_all.map do |k, v|
      {
        day: Time.zone.at(k.to_i).to_date.strftime("%F"),
        value: v.to_i
      }
    end
  end

  def browser_name
    @app.visits.group(:browser_name).count
        .map do |k, v|
      {
        id: k || "unknown",
        label: k || "unknown",
        value: v,
        color: "hsl(#{colors}, 70%, 50%)"
      }
    end
  end

  def browser
    @app.visits.group(:browser_name).count
        .map do |k, v|
      {
        id: k || "unknown",
        label: k || "unknown",
        value: v,
        color: "hsl(#{colors}, 70%, 50%)"
      }
    end
  end

  def lead_os
    @app.app_users.visitors.group(:os).count
        .map do |k, v|
      { id: k || "unknown",
        label: k || "unknown",
        value: v,
        color: "hsl(#{colors}, 70%, 50%)" }
    end
  end

  def user_os
    @app.app_users.group(:os).count
        .map do |k, v|
      { id: k || "unknown",
        label: k || "unknown",
        value: v,
        color: "hsl(#{colors}, 70%, 50%)" }
    end
  end

  def user_country
    @app.app_users.group(:country).count
        .map do |k, v|
      { id: k || "unknown",
        label: k || "unknown",
        value: v,
        color: "hsl(#{colors}, 70%, 50%)" }
    end
  end

  def first_response_time
    @app.stats_counts_for("first_response_time")
  end

  def incoming_messages
    @app.stats_counts_for("incoming_messages")
  end

  def outgoing_messages
    @app.stats_counts_for("outgoing_messages")
  end

  def opened_conversations
    @app.stats_counts_for("opened_conversations")
  end

  def solved_conversations
    @app.stats_counts_for("solved_conversations")
  end

  def resolution_avg
    @app.stats_for("resolution_avg")
  end

  def colors
    array = %w[265 20 30 110 120 160 260 270 290 330 400]
    array.sample
  end
end
