system Cookbook
===============
This cookbook sets up the user accts for the system. Any libraries that are needed as a base for the system, etc.

Requirements
------------
Ubuntu OS

Attributes
----------

#### system::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['system']['user']</tt></td>
    <td>String</td>
    <td>The default system user</td>
    <td><tt>ubuntu</tt></td>
  </tr>
</table>

Usage
-----
#### system::default

Just include `system` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[system]"
  ]
}
```
