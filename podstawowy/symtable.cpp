#include "global.h"

Symtable::Symtable(){} 

int Symtable::insert_to_table(string s, Input_type t)
{   
    if(t == identifier)
    {
        Record new_record;
        new_record.name = s;
        new_record.address = next_address;
        next_address += 4;
        table.push_back(new_record);
        return table.size() - 1;
    }
    if(t == number)
    {
        Record new_record;
        new_record.name = s;
        new_record.value = stoi(s);
        table.push_back(new_record);
        return table.size() - 1;
    }
    if(t == temporary){
        Record new_record;
        new_record.name = s + to_string(next_temp);
        next_temp += 1;
        new_record.address = next_address;
        next_address += 4;
        table.push_back(new_record);
        return table.size() - 1;
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
        cout << "|" << table[i].name << "\t|" <<table[i].type_of_variable << "\t|" << table[i].value << "\t|" 
        << table[i].address << endl;
    }
}