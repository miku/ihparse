README
======

ihparse parses XML files that represent *institutional holdings*.

Example input:

    <?xml version="1.0" encoding="UTF-8"?>
    <institutional_holdings>
      <item type="electronic">
        <title>Journal of Molecular Modeling</title>
        <issn>0948-5023</issn>
        <coverage>
          <from>
            <year>1995</year>
            <volume>1</volume>
          </from>
          <to>
            <year>2002</year>
            <volume>8</volume>
          </to>
          <comment>Nationallizenz</comment>
        </coverage>
        <coverage>
          <from>
            <year>1995</year>
            <volume>1</volume>
            <issue>1</issue>
          </from>
          <comment>Konsortiallizenz - Gesamter Zeitraum</comment>
        </coverage>
      </item>
      ...
    </institutional_holdings>
