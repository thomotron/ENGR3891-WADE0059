Deep-Dive 1 - Wiki wiki wild wild west
===

## Table of Contents


## Introduction


## Wiki Selection


### Selection Criteria
Must-haves:  
- Free (Libre) and open source  
  The source code for the wiki should be publicly available and freely modifiable.
- Plugin support  
  The wiki should be able to load additional modules to extend or introduce new functionality.
- Simple setup  
  Setup should be a guided process with minimal interaction with configuration files or installation of many dependencies.
- Media support  
  Various media types (audio, video, images) should be able to be embedded into wiki pages.
- Administration tools  
  Administrators should be able to manage users, page editability, and other wiki functionality without modifying configuration files.
- Change tracking/history  
  All changes to pages should be tracked and reversible.
- Modern appearance  
  The wiki should look clean and modern for ease of navigation.
- Last updated within 12 months  
  The wiki should not be deprecated or unmaintained.

Nice-to-haves:  
- Markdown support  
  Support for editing pages in markdown is a nice feature and would eliminate the need to learn a different markup format.
- Web-server agnostic  
  The wiki should be able to run on most web servers.

### Candidates
These candidates were selected after a brief search for free and/or open-source wiki packages:
 - TWiki
 - MediaWiki
 - PmWiki
 - Gollum Wiki
 - XWiki
 - Wiki.js
 - TiddlyWiki

The following table compares each candidate based on the criteria mentioned earlier:

| Candidate   | Licence      | Plugin support | Simple setup | Embeddable media | Admin tools | Change tracking | Modern appearance | Recently updated | Markdown | Web server agnostic | Language   |
| ----------- | ------------ | -------------- | ------------ | ---------------- | ----------- | --------------- | ----------------- | ---------------- | -------- | ------------------- | ---------- |
| TWiki       | GPL          | Yes            | No           | Yes              | Yes         | Yes             | No                | Yes              | No       | Yes                 | Perl       |
| MediaWiki   | GPL          | Yes            | Yes          | Yes              | Yes         | Yes             | With skin         | Yes              | Plugin   | Yes                 | PHP        |
| PmWiki      | GPL          | Yes            | No           | Yes              | Yes         | Yes             | With skin         | Yes              | Plugin   | Yes                 | PHP        |
| Gollum Wiki | MIT          | No             | Yes          | Yes              | No          | Yes             | Yes               | Yes              | Yes      | No                  | Ruby       |
| XWiki       | LGPLv2.1     | Yes            | Yes          | Yes              | Yes         | Yes             | Yes               | Yes              | Plugin   | Yes                 | Java       |
| Wiki.js     | AGPLv3       | Yes            | No           | Yes              | Yes         | Yes             | Yes               | Yes              | Yes      | No                  | JavaScript |
| TiddlyWiki  | BSD 3-Clause | Yes            | Yes          | No               | No          | Plugin          | Yes               | Yes              | Plugin   | Yes                 | JavaScript |
