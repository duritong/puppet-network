module Puppet::Parser::Functions
  newfunction(:cidr2netmask, :doc => <<-'ENDHEREDOC') do |args|
    convert cidr notation into a netmask
    ENDHEREDOC

    unless args.length == 1
      raise Puppet::ParseError, ("cidr2netmask(): expects one argument")
    end
    begin
      cidr = Integer(args[0])
    rescue
      raise Puppet::ParseError, ("cidr2netmask(): expects integer")
    end

    netmask = ((1 << (32 - cidr)) - 1) ^ ((1 << 32) - 1)
    a = netmask >> 24
    b = (netmask >> 16) & 255
    c = (netmask >> 8) & 255
    d = netmask & 255
    "#{a}.#{b}.#{c}.#{d}"
  end
end


