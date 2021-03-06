# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

class TestFlightClient < Test::Unit::TestCase
  def setup
    @server = nil
    omit("Arrow Flight is required") unless defined?(ArrowFlight)
    @server = Helper::FlightServer.new
    host = "127.0.0.1"
    location = ArrowFlight::Location.new("grpc://#{host}:0")
    options = ArrowFlight::ServerOptions.new(location)
    @server.listen(options)
    @location = ArrowFlight::Location.new("grpc://#{host}:#{@server.port}")
  end

  def shutdown
    return if @server.nil?
    @server.shutdown
  end

  def test_connect
    # TODO: Add tests that use other methods and remove this.
    assert_nothing_raised do
      ArrowFlight::Client.new(@location)
    end
  end
end
