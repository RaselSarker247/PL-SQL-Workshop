declare
  cursor c1 is
    with x as (
      select '
<company>
  <team>
    <employee>
      <name>Joe</name>
      <surname>Bloggs</surname>
    </employee>
  </team>
</company>' as x1
, '
<company>
  <team>
    <employee>
      <name>Joe</name>
      <surname>Bloggs</surname>
    </employee>
    <employee>
      <name>Jane</name>
      <surname>Doe</surname>
    </employee>
  </team>
</company>' as x2
      from dual
    )
    select xmltype(x.x1) as x1_xmltype
    ,      xmltype(x.x2) as x2_xmltype
    from x
  ;
begin
  apex_json.initialize_clob_output;
  for r1 in c1 loop
    apex_json.write(r1.x1_xmltype);
    apex_json.write(r1.x2_xmltype);
    dbms_output.put_line(apex_json.get_clob_output);
  end loop;
  apex_json.free_output;
end;
