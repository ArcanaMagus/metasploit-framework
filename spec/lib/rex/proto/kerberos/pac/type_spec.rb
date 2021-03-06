# -*- coding:binary -*-
require 'spec_helper'

require 'rex/proto/kerberos'

describe Rex::Proto::Kerberos::Pac::Type do

  subject(:pac_type) do
    described_class.new
  end

  let(:sample) do
    "\x04\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\xb0\x01\x00\x00" +
    "\x48\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x00\x00\x12\x00\x00\x00" +
    "\xf8\x01\x00\x00\x00\x00\x00\x00\x06\x00\x00\x00\x14\x00\x00\x00" +
    "\x10\x02\x00\x00\x00\x00\x00\x00\x07\x00\x00\x00\x14\x00\x00\x00" +
    "\x28\x02\x00\x00\x00\x00\x00\x00\x01\x10\x08\x00\xcc\xcc\xcc\xcc" +
    "\xa0\x01\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x1e\x7c\x42" +
    "\xfc\x18\xd0\x01\xff\xff\xff\xff\xff\xff\xff\x7f\xff\xff\xff\xff" +
    "\xff\xff\xff\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\x7f\x08\x00\x08\x00" +
    "\x04\x00\x02\x00\x00\x00\x00\x00\x08\x00\x02\x00\x00\x00\x00\x00" +
    "\x0c\x00\x02\x00\x00\x00\x00\x00\x10\x00\x02\x00\x00\x00\x00\x00" +
    "\x14\x00\x02\x00\x00\x00\x00\x00\x18\x00\x02\x00\x00\x00\x00\x00" +
    "\xe8\x03\x00\x00\x01\x02\x00\x00\x05\x00\x00\x00\x1c\x00\x02\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x20\x00\x02\x00\x14\x00\x14\x00" +
    "\x24\x00\x02\x00\x28\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x10\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00" +
    "\x6a\x00\x75\x00\x61\x00\x6e\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
    "\x00\x00\x00\x00\x05\x00\x00\x00\x01\x02\x00\x00\x07\x00\x00\x00" +
    "\x00\x02\x00\x00\x07\x00\x00\x00\x08\x02\x00\x00\x07\x00\x00\x00" +
    "\x06\x02\x00\x00\x07\x00\x00\x00\x07\x02\x00\x00\x07\x00\x00\x00" +
    "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x00\x00" +
    "\x00\x00\x00\x00\x0a\x00\x00\x00\x44\x00\x45\x00\x4d\x00\x4f\x00" +
    "\x2e\x00\x4c\x00\x4f\x00\x43\x00\x41\x00\x4c\x00\x04\x00\x00\x00" +
    "\x01\x04\x00\x00\x00\x00\x00\x05\x15\x00\x00\x00\x03\x99\xa8\x68" +
    "\xe0\x0e\x0e\xd9\x9a\x18\xcf\xcf\x00\x1e\x7c\x42\xfc\x18\xd0\x01" +
    "\x08\x00\x6a\x00\x75\x00\x61\x00\x6e\x00\x00\x00\x00\x00\x00\x00" +
    "\x07\x00\x00\x00\x48\x0b\x02\xf8\xfe\x54\x02\x96\x7d\x7e\xee\x24" +
    "\x12\x73\x67\x4e\x00\x00\x00\x00\x07\x00\x00\x00\x91\x35\x2a\xc2" +
    "\x7c\x08\x1c\xa7\x88\xd9\x63\xbb\x23\x71\xb8\x64\x00\x00\x00\x00"
  end

  let(:rsa_md5) { 7 }

  describe "#encode" do
    context "when RSA-MD5 checksums" do
      it "encodes the PAC-TYPE correctly" do
        logon_info = Rex::Proto::Kerberos::Pac::LogonInfo.new(
          logon_time: Time.at(1418712492),
          effective_name: 'juan',
          user_id: 1000,
          primary_group_id: 513,
          group_ids: [513, 512, 520, 518, 519],
          logon_domain_name: 'DEMO.LOCAL',
          logon_domain_id: 'S-1-5-21-1755879683-3641577184-3486455962',
        )

        client_info = Rex::Proto::Kerberos::Pac::ClientInfo.new(
          client_id: Time.at(1418712492),
          name: 'juan'
        )

        server_checksum = Rex::Proto::Kerberos::Pac::ServerChecksum.new(
          checksum: rsa_md5
        )

        priv_srv_checksum = Rex::Proto::Kerberos::Pac::PrivSvrChecksum.new(
          checksum: rsa_md5
        )

        pac_type.buffers = [
          logon_info,
          client_info,
          server_checksum,
          priv_srv_checksum
        ]

        pac_type.checksum = rsa_md5

        expect(pac_type.encode).to eq(sample)
      end
    end
  end
end

