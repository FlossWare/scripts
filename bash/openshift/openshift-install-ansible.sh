#!/bin/bash 

#
# This file is part of the FlossWare family of open source software.
#
# FlossWare is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
#

#
# This script will install Ansible at Openshift.  Note this script has to be run
# at your openshift instance.
#
# To use:
#   openshift-install-ansible
#

# --------------------------------------------------------------------
# Installing ansible
# --------------------------------------------------------------------

. `dirname ${BASH_SOURCE[0]}`/openshift-config.sh

echo "127.0.0.1" > ${OPENSHIFT_DATA_DIR}/ansible_hosts

mkdir -p ${ANSIBLE_LOCAL_TEMP}

cp `dirname ${BASH_SOURCE[0]}`/openshift-ansible.cfg ${ANSIBLE_CONFIG}

pip install ansible
pip install --upgrade ansible setuptools
