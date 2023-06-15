validInput(val , min ,max){
  if(val.length> max){
    var messageInputMax="لا يمكن ان يكون الحقل اكبر من $max";
    return"$messageInputMax $max";
  }
    if(val.isEmpty){
    var messageInputEmpty = "لا يمكن ان يكون هذا الحقل فارغا";
    return messageInputEmpty;

  }
  if(val.length < min){
    var messageInputMin="لا يمكن ان يكون الحقل اصغر من $min";
    return"$messageInputMin $min";
  }

}