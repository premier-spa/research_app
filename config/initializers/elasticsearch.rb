Elasticsearch::Model.client = Elasticsearch::Client.new({log: true, hosts: { host: 'search'}})