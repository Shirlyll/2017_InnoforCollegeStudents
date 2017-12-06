using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace _2017Jack
{
    public class Class
    {
    }
    public class EntityList
    {
        public ArrayList entitylist = new ArrayList();
        public int level;
        public int ChildCount;
    }
    public class EntityBase
    {
        public string id;
        public string available;
    }

    public class JackEntity : EntityBase
    {
        public string JackType;
        public string JackName;
        public string userId;
        public string LinkState;
        public string WorkState;


    }
    public class SuggestionEntity:EntityBase
    {
        public string userId;
        public string userSuggestion;
        public string SubmitDate;
        public string ReadState;
    }
    public class UserEntity: EntityBase
    {
        public string userId;
        public string userName;
        public string userImagePath;
    }
}