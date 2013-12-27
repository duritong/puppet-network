module Puppet::Parser::Functions
  newfunction(:cidr2netmask, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |arg|
    convert cidr notation into a netmask
    ENDHEREDOC

    unless arg.length == 1
      raise Puppet::ParseError, ("cidr2netmask(): expects one argument")
    end
    begin
      cidr = Integer(arg[0])
    rescue
      raise Puppet::ParseError, ("cidr2netmask(): expects integer")
    end

    netmask = ((1 << (32 - cidr)) - 1) ^ ((1 << 32) - 1)
    a = netmask >> 24
    b = (netmask >> 16) & 255
    c = (netmask >> 8) & 255
    d = netmask & 255
    return "#{a}.#{b}.#{c}.#{d}"
  end
end


