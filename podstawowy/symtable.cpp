#include "global.h"

Symtable::Symtable(){} 

int Symtable::insert_to_table(string s, Input_type IT)
{   
    Record new_record;
    switch(IT){
    case Input_type::IDENTIFIER: //swtich
        new_record.name = s;
        new_record.address = 0;
        table.push_back(new_record);
        return table.size() - 1;
        break;

    case Input_type::NUMBER:
        new_record.name = s;
        new_record.value = stoi(s);
        table.push_back(new_record);
        return table.size() - 1;
        break;

    case Input_type::TEMPORARY:
        new_record.name = s + to_string(next_temp);
        next_temp += 1;
        new_record.address = next_address;
        next_address += 4;
        new_record.type = (VarType)INTEGER;
        table.push_back(new_record);
        return table.size() - 1;
        break;
    }
    return -1;
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
    string column_names[4] = {"Name", "Type", "Value", "Address"};
    for(int i=0; i<4; i++){
        cout << "|" << column_names[i] << "\t";
    }
    cout << "\n" + string(30,'-') << endl;



    for(int i=0; i < (int)table.size(); i++)
    {
        cout << "|" << table[i].name << "\t|" << table[i].type << "\t|" << table[i].value << "\t|" 
        << table[i].address << endl;
    }
}