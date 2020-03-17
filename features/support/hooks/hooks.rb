# Author: Pablo Ramirez
# Connection Database
# Create Subscriptions
Before do
  host_port = Env.host_port_db
  method = 'post'
  data_base_es = Env.data_base_es
  data_base_rm = Env.data_base_rm

  $db_es = Mongodb.new(host_port, data_base_es)
  $db_rm = Mongodb.new(host_port, data_base_rm)

  Hooks_helper.request_post_hook(method, 'subscriptions', 'host', Env.key_header_es.to_sym,
                                 Helper.encode_credentials(Env.user_password),
                    Env.host_subscriptions,
                    Env.body_subscriptions)

  Hooks_helper.request_post_hook(method, 'services', 'hostname',
                    Env.hostname,
                    Env.body_services)
end

# Delete all meetings
Before('@delete_meetings') do
  $db_es.drop 'meetings'
  $db_rm.drop 'meetings'
end

# Delete services
Before('@delete_services') do
  $db_es.drop 'services'
  $db_rm.drop 'services'
end

# Delete rooms
Before('@delete_rooms') do
  $db_rm.drop 'rooms'
end

# Author Juan Aitken
# Delete subscriptions
Before('@delete_subscriptions') do
  $db_es.drop 'subscriptions'
end

# Close Database
After do
  $db_es.close_connection
  $db_rm.close_connection
end

