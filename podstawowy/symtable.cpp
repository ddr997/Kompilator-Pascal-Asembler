#include "global.h"

Symtable::Symtable(){} 

int Symtable::insert_to_table(string s)
{
    Record new_record;
    new_record.type_of_variable = none;
    new_record.name = s;
    new_record.address = next_address;
    next_address += 4;
    table.push_back(new_record);
    return table.size() - 1;
}

int Symtable::find_in_table(string s)
{
    for(int i=0; i< (int) table.size(); i++)
    {
        if(table.at(i).name == s)
        {
            return i;
        }
    }
    return -1;
}

void Symtable::print_table()
{
    for(int i=0; i < (int)table.size(); i++)
    {
        cout << table[i].name << " " <<table[i].type_of_variable << " " << table[i].value << " " 
        << table[i].address << endl;
    }
}