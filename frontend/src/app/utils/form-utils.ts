
import { FormArray, FormGroup } from '@angular/forms';

export class FormUtils {

  static markAllAsTouched(form: any) {
    Object.keys(form.controls).forEach(key => {
      if (form.controls[key] instanceof FormGroup || form.controls[key] instanceof FormArray) {
        this.markAllAsTouched(form.controls[key]);
      }
      form.controls[key].markAsTouched();
    });
  }

  static markAllAsDirty(form: any) {
    Object.keys(form.controls).forEach(key => {
      if (form.controls[key] instanceof FormGroup || form.controls[key] instanceof FormArray) {
        this.markAllAsDirty(form.controls[key]);
      }
      form.controls[key].markAsDirty();
    });
  }
}
