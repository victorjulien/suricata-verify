Test that directly calling the metatable garbard collector doesn't crash
Suricata. This requires disabling the sandbox, but we are still able to guard
against it.

https://redmine.openinfosecfoundation.org/issues/8248
