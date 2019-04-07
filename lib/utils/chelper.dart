class CHelper{
  static final CHelper _instance=new CHelper.internal();
  factory CHelper()=>_instance;
  CHelper.internal();
  List order(List list, int s){
    List past=new List.from(list);
    List rList=new List(3);
    rList[1]=s;
    past.remove(s);    
    rList.first=past[0];
    past.remove(past[0]);
    rList.last=past[0];    
    return rList;
  }
  List<List> dataIn(List list){
    List<List<int>> mat=new List.generate(7, (i)=>[]);
    var c=0;
    for(var i=0; i<=6; i++){
      for(var j=0; j<=2; j++){
        mat[i].add(list[c]);
        c++;
      }
    }    
    return mat;
  }
  List joinMatriz(List<List> mat, List guid, var chs){
    guid=order(guid, chs);
    List m=new List();
    for(var f=0; f<=2; f++){
      for(var g=0; g<=6; g++){
        m.add(mat[g][guid[f]]);
      }
    }    
    return m;
  }
}