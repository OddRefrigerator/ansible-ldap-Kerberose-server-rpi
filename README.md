# Ansible Role: LDAP + Kerberos Server on Raspberry Pi

This Ansible role automates the installation and configuration of an LDAP server and a Kerberos server on a Raspberry Pi. It is designed for small-scale networks where central authentication is required, such as home labs, educational setups, or small offices.

## Features

- **Automated LDAP Installation:** Installs and configures OpenLDAP server for centralized directory services.
- **Kerberos Server Setup:** Configures Kerberos for secure authentication and single sign-on (SSO) functionality.
- **Customizable Settings:** Allows the configuration of domain names, Kerberos realms, admin credentials, and other LDAP/Kerberos settings.
- **Raspberry Pi Compatibility:** Optimized for lightweight deployment on Raspberry Pi devices.
- **Secure Communication:** Ensures communication via secure channels with SSL/TLS for LDAP and Kerberos.

## Requirements

- Raspberry Pi running a compatible OS (e.g., Raspberry Pi OS).
- Ansible installed on the control machine.
- Root or sudo privileges on the Raspberry Pi.

## Role Variables

Key variables for LDAP and Kerberos configuration are located in the `defaults/main.yml` file. Here are some important ones:

```yaml
# Domain and organization settings for LDAP
ldap_domain: "example.com"
ldap_organization: "Example Organization"

# Kerberos realm settings
kerberos_realm: "EXAMPLE.COM"
kerberos_domain: "example.com"

# LDAP admin credentials
ldap_admin_password: "admin_password"

# Kerberos admin credentials
kerberos_admin_password: "admin_password"
```

These variables can be overridden in your playbook or inventory.

## Example Playbook

Here is an example of how to use this role in your playbook:

```yaml
---
- hosts: raspberrypi
  become: true
  roles:
    - role: ansible-ldap-Kerberose-server-rpi
      vars:
        ldap_domain: "mydomain.com"
        ldap_organization: "My Organization"
        ldap_admin_password: "supersecretpassword"
        kerberos_realm: "MYDOMAIN.COM"
        kerberos_domain: "mydomain.com"
        kerberos_admin_password: "supersecurepassword"
```

## Installation

To install and use this role:

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/OddRefrigerator/ansible-ldap-Kerberose-server-rpi.git
   ```

2. Include the role in your Ansible playbook.

3. Run the playbook to configure the LDAP and Kerberos servers on your Raspberry Pi:
   ```bash
   ansible-playbook -i inventory my-playbook.yml
   ```

## Security Considerations

- Ensure that your passwords are securely stored, either by encrypting them using [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) or managing them via an external secret management system.
- Enable TLS/SSL for secure LDAP communication.
- Ensure that proper firewall rules are in place to protect the server.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! If you have suggestions for improvements or encounter any issues, feel free to open an issue or submit a pull request.

### Steps for Contribution

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Description of your feature or fix"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a Pull Request and provide a detailed explanation of your changes.

## Author

This role was created by [OddRefrigerator](https://github.com/OddRefrigerator).

## Contact

For any inquiries or issues, feel free to open an issue on GitHub or contact the repository owner.
